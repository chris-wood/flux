module FluxLexer where

import Text.Parsec.String (Parser)
import Text.Parsec.Language (emptyDef)

import qualified Text.Parsec.Token as Token

lexer :: Token.TokenParser ()
lexer = Token.makeTokenParser style
  where
    ops = ["+","*","-",";",",","<",">","<=",">=","==","!="]
    names = ["def","extern","if","then","else","in","for","flow","receive","send","push","wait","schedule"]
    style = emptyDef {
               Token.commentLine = "#"
             , Token.reservedOpNames = ops
             , Token.reservedNames = names
             }

integer :: Parser Integer
integer = Token.integer lexer

float :: Parser Double
float = Token.float lexer

identifier :: Parser String
identifier = Token.identifier lexer

parens :: Parser a -> Parser a
parens = Token.parens lexer

semiSep :: Parser a -> Parser [a]
semiSep = Token.semiSep lexer

commaSep :: Parser a -> Parser[a]
commaSep = Token.commaSep lexer

whitespace = Token.whiteSpace lexer

reserved :: String -> Parser ()
reserved = Token.reserved lexer

reservedOp :: String -> Parser ()
reservedOp = Token.reservedOp lexer
