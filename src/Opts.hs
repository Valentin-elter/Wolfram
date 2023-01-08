--
-- EPITECH PROJECT, 2021
-- Opts.hs
-- File description:
-- filling opts
--

module Opts
        (       getOpts,
                defaultConf
        ) where

import System.Environment
import System.Exit
import System.IO
import Text.Read
import Lib

defaultConf :: Conf
defaultConf = Conf (Nothing) 0 (-1) 80 0

updateRule :: Conf -> [String] -> Conf
updateRule (Conf (Nothing) s l w m) ("--rule":y:xs) =
    (Conf (readMaybe y :: Maybe Int) s l w m)
updateRule (Conf (Nothing) s l w m) (x:y:xs) =
    updateRule (Conf Nothing s l w m) xs

getOpts :: Conf -> [String] -> Conf
getOpts config [] = config
getOpts (Conf (Nothing) s l w m) args =
    getOpts (updateRule (Conf (Nothing) s l w m) args) args
getOpts (Conf (Just r) s l w m) args =
    getRule (Conf (Just r) s l w m) args

getRule:: Conf -> [String] -> Conf
getRule (Conf (Just r) s l w m) ("--rule":y:xs) =
    getOpts (Conf (readMaybe y :: Maybe Int) s l w m) xs
getRule (Conf (Just r) s l w m) args =
    getStart (Conf (Just r) s l w m) args

getStart:: Conf -> [String] -> Conf
getStart (Conf (Just r) s l w m) ("--start":y:xs) =
    getOpts (Conf (Just r) (read y ::Int) l w m) xs
getStart (Conf (Just r) s l w m) args =
    getLines (Conf (Just r) s l w m) args

getLines:: Conf -> [String] -> Conf
getLines (Conf (Just r) s l w m) ("--lines":y:xs) =
    getOpts (Conf (Just r) s (read y ::Int) w m) xs
getLines (Conf (Just r) s l w m) args =
    getWindow (Conf (Just r) s l w m) args

getWindow:: Conf -> [String] -> Conf
getWindow (Conf (Just r) s l w m) ("--window":y:xs) =
    getOpts (Conf (Just r) s l (read y ::Int) m) xs
getWindow (Conf (Just r) s l w m) args =
    getMove (Conf (Just r) s l w m) args

getMove:: Conf -> [String] -> Conf
getMove (Conf (Just r) s l w m) ("--move":y:xs) =
    getOpts (Conf (Just r) s l w (read y ::Int)) xs
getMove (Conf (Just r) s l w m) args =
    getOpts (Conf (Just r) s l w m) args