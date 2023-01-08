module Main where

import Lib
import System.Environment
import System.Exit
import System.IO
import Text.Read
import Errs
import Lib
import Opts
import Wolfram

main :: IO ()
main = do
    args <- getArgs
    case checkErr args of
        True -> do
            let x = getOpts defaultConf args
            doWolfram x "*" 0
            exitWith (ExitSuccess)
        False ->    usage >>
                    exitWith (ExitFailure 84)
