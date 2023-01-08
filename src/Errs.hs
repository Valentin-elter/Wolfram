--
-- EPITECH PROJECT, 2021
-- Errs.hs
-- File description:
-- check args errors
--

module Errs
        (       checkErr,
                usage
        ) where

import System.Environment
import System.Exit
import System.IO
import Text.Read
import Lib

usage :: IO ()
usage = hPutStrLn stderr text
        where text = "Usage: Wolfram --rule X (the ruleset to use)\n\nflags:"
                ++ "\n--start X (the generation number at which to start the "
                ++ "display) \n--lines X (the number of lines to display. "
                ++ "When omitted, the program never stops)\n--window X (the "
                ++ "number of cells to display on each line)\n--move X (a "
                ++ "translation to apply on the window. If negative, the "
                ++ "window is translated to the left. If positive, it’s "
                ++ "translated to the right)"

belongsTab :: String -> [String] -> Bool
belongsTab word (x:xs) = case word == x of
                            True -> True
                            False -> belongsTab word xs
belongsTab word _ = False

isNum :: String -> Bool
isNum (x:xs) = case x >= '0' && x <= '9' of
                True -> isNum xs
                False -> False
isNum _ = True

argErr :: [String] -> Bool
argErr [] = True
argErr (x:y:xs) = case belongsTab x opt && y /= "" && isNum y of
                    True -> argErr xs
                    False -> False
    where opt = ["--rule", "--start", "--lines", "--window", "--move"]
argErr _ = False

checkMandatory :: [String] -> Bool
checkMandatory (x:y:xs) = case x == "--rule" && (y == "30" ||
                                    y == "90" || y == "110") of
                            True -> True
                            False -> checkMandatory xs
checkMandatory _ = False

checkErr :: [String] -> Bool
checkErr [] = False
checkErr [""] = False
checkErr args = case argErr args && checkMandatory args of
    True -> True
    False -> False