module FluxSyntax where

type Name = String

data Expr
    = Float Double
    | BinOp Op Expr Expr
    | UnOp Op Expr
    | Var String
    | Call Name [Expr]
    | Function Name [Expr] Expr
    | Extern Name [Expr]
    | If Expr Expr Expr
    | For Name Expr Expr Expr Expr
    | Let Name Expr Expr
    | Flow Name Expr
    deriving (Eq, Ord, Show)

data Op
    = Plus
    | Minus
    | Times
    | Divide
    | LessThan
    deriving (Eq, Ord, Show)
