module FluxParser where

import Text.Parsec
import Text.Parsec.String (Parser)

import qualified Text.Parsec.Expr as Ex
import qualified Text.Parsec.Token as Token

import FluxLexer
import FluxSyntax

binary s f assoc = Ex.Infix (reservedOp s >> return (BinOp f)) assoc

table = [[binary "*" Times Ex.AssocLeft,
          binary "/" Divide Ex.AssocLeft],
         [binary "+" Plus Ex.AssocLeft,
          binary "-" Minus Ex.AssocLeft],
         [binary "<" LessThan Ex.AssocLeft]]

int :: Parser Expr
int = do
    n <- integer
    return $ Float (fromInteger n)

floating :: Parser Expr
floating = do
    n <- float
    return $ Float n

expr :: Parser Expr
expr = Ex.buildExpressionParser table factor

variable :: Parser Expr
variable = do
    var <- identifier
    return $ Var var

function :: Parser Expr
function = do
    reserved "def"
    name <- identifier
    args <- parens $ many variable
    body <- expr
    return $ Function name args body

extern :: Parser Expr
extern = do
    reserved "extern"
    name <- identifier
    args <- parens $ many variable
    return $ Call name args

call :: Parser Expr
call = do
    name <- identifier
    args <- parens $ commaSep expr
    return $ Call name args

factor :: Parser Expr
factor = try floating
    <|> try int
    <|> try extern
    <|> try function
    <|> try call
    <|> try flow
    <|> ifthen
    <|> for
    <|> variable
    <|> (parens expr)

defn :: Parser Expr
defn = try extern
    <|> try function
    <|> expr

ifthen :: Parser Expr
ifthen = do
    reserved "if"
    cond <- expr
    reserved "then"
    tr <- expr
    reserved "else"
    fl <- expr
    return $ If cond tr fl

for :: Parser Expr
for = do
    reserved "for"
    var <- identifier
    reservedOp "="
    start <- expr
    reservedOp ","
    cond <- expr
    reservedOp ","
    step <- expr
    reserved "in"
    body <- expr
    return $ For var start cond step body

flow :: Parser Expr
flow = do
    reserved "flow"
    link <- identifier
    reserved "{"
    body <- expr
    reserved "}"
    return $ Flow link body

contents :: Parser a -> Parser a
contents p = do
    Token.whiteSpace lexer
    r <- p
    eof
    return r

toplevel :: Parser [Expr]
toplevel = many $ do
    def <- defn
    reservedOp ";"
    return def

parseExpr :: String -> Either ParseError Expr
parseExpr s = parse (contents expr) "<stdin>" s

parseTopLevel :: String -> Either ParseError [Expr]
parseTopLevel s = parse (contents toplevel) "<stdin>" s
