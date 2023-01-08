--
-- EPITECH PROJECT, 2021
-- Wolfram.hs
-- File description:
-- Wolfram app
--

module Wolfram
        (       doWolfram
        ) where

import System.Environment
import System.Exit
import System.IO
import Text.Read
import Lib

doRule30 :: (Char, Char, Char) -> Char
doRule30 ('*', '*', '*' ) = ' '
doRule30 ('*', '*', ' ' ) = ' '
doRule30 ('*', ' ', '*' ) = ' '
doRule30 ('*', ' ', ' ' ) = '*'
doRule30 (' ', '*', '*' ) = '*'
doRule30 (' ', '*', ' ' ) = '*'
doRule30 (' ', ' ', '*' ) = '*'
doRule30 (' ', ' ', ' ' ) = ' '

doRule90 :: (Char, Char, Char) -> Char
doRule90 ('*', '*', '*' ) = ' '
doRule90 ('*', '*', ' ' ) = '*'
doRule90 ('*', ' ', '*' ) = ' '
doRule90 ('*', ' ', ' ' ) = '*'
doRule90 (' ', '*', '*' ) = '*'
doRule90 (' ', '*', ' ' ) = ' '
doRule90 (' ', ' ', '*' ) = '*'
doRule90 (' ', ' ', ' ' ) = ' '

doRule110 :: (Char, Char, Char) -> Char
doRule110 ('*', '*', '*' ) = ' '
doRule110 ('*', '*', ' ' ) = '*'
doRule110 ('*', ' ', '*' ) = '*'
doRule110 ('*', ' ', ' ' ) = ' '
doRule110 (' ', '*', '*' ) = '*'
doRule110 (' ', '*', ' ' ) = '*'
doRule110 (' ', ' ', '*' ) = '*'
doRule110 (' ', ' ', ' ' ) = ' '

makeTuples :: [Char] -> Int -> (Char, Char, Char)
makeTuples line 0 = (' ', line!!0, line!!1)
makeTuples line n = case length line == (n + 1) of
                        True -> (line!!(n-1), line!!n, ' ')
                        False -> (line!!(n-1), line!!n, line!!(n+1))

addSpaceStr :: [Char] -> [Char]
addSpaceStr line = (' ':line) ++ [' ']

giveNextLine :: Conf -> [Char] -> Int -> [Char]
giveNextLine (Conf (Just r) s l w m) line n
    | (length line + 2) == n = ""
    | r == 30 = doRule30 parentsCell : giveNextLine config line (n + 1)
    | r == 90 = doRule90 parentsCell : giveNextLine config line (n + 1)
    | r == 110 = doRule110 parentsCell : giveNextLine config line (n + 1)
    where   parentsCell = (makeTuples (addSpaceStr line) n)
            config = (Conf (Just r) s l w m)

putSpace :: Conf -> Int -> IO ()
putSpace (Conf (Just r) s l w m) n =
    putStr (take ((div w 2) - n + m) [' ',' '..])

putSpaceLn :: Conf -> Int -> IO ()
putSpaceLn (Conf (Just r) s l w m) n =
    putStrLn (take ((div w 2) - n - 1) [' ',' '..])

makeLine :: Conf -> [Char] -> Int -> IO ()
makeLine (Conf (Just r) s l w m) line n =
    putSpace (Conf (Just r) s l w m) n >>
    putStr (take w (drop (div (length line - w) 2) line)) >>
    putSpaceLn (Conf (Just r) s l w m) n

doWolfram :: Conf -> [Char] -> Int -> IO ()
doWolfram (Conf (Just r) s 0 w m) line 0 = putStrLn ""
doWolfram (Conf (Just r) s l w m) line n
    | n < s = nextLine
    | (n + 1) /= (s + l) =  printLine >>
                            nextLine
    | (n + 1) == (s + l) = printLine
    where   nextLine = doWolfram (Conf (Just r) s l w m)
                (giveNextLine (Conf (Just r) s l w m) line 0) (n + 1)
            printLine = makeLine (Conf (Just r) s l w m) line n