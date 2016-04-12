module FluxMain where

import FluxParser

import System.IO
import System.Environment
import System.Console.Haskeline

import Control.Monad.Trans
import System.Console.Haskeline

process :: String -> IO ()
process line = do
    let res = parseTopLevel line
    case res of
        Left err -> print err
        Right ex -> mapM_ print ex

repl :: IO ()
repl = runInputT defaultSettings loop
    where
    loop = do
        minput <- getInputLine "flux> "
        case minput of
            Nothing -> outputStrLn "Goodbye."
            Just input -> (liftIO $ process input) >> loop

main :: IO ()
main = do
    args <- getArgs
    case args of
        []  -> repl
        [_] -> repl
        --[fname] -> processFile fname >> return ()
    
