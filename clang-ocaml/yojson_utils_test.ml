(*
 *  Copyright (c) 2014, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 *)

open Clang_ast_j
open Yojson_utils

let data = {
  sl_file = Some "foo";
  sl_line = Some 1;
  sl_column = None
}

let test pretty name =
  write_data_to_file ~pretty write_source_location name data;
  let data3 = read_data_from_file read_source_location name in
  Unix.unlink name;
  if data <> data3 then begin
    Printf.fprintf stderr "** failed test %s pretty=%b **\n" name pretty;
    exit 1
  end;
  ()

let test1 =
  List.iter (test false) [
    "yojson_utils_test_tmpfile.gz";
    "yojson_utils_test_tmpfile.value";
    "yojson_utils_test_tmpfile.yjson"
  ]

let test2 =
  List.iter (test true) [
    "yojson_utils_test_tmpfile.gz";
    "yojson_utils_test_tmpfile.value";
    "yojson_utils_test_tmpfile.yjson"
  ]