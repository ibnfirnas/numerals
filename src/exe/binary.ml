module List = ListLabels

module Number : sig
  type t

  val zero : t
  val add  : t -> int -> t
  val to_string : t -> string
end = struct
  module Digit = struct
    type t =
      | D0
      | D1

    let to_string = function
      | D0 -> "0"
      | D1 -> "1"
  end

  type t =
    Digit.t list

  let to_string = function
    | [] -> Digit.to_string Digit.D0
    | t  -> String.concat "" (List.rev (List.map t ~f:Digit.to_string))

  let zero =
    [Digit.D0]

  let rec add_1 : (t -> t) = function
    | []             -> Digit.D1 :: []
    | Digit.D0 :: ds -> Digit.D1 :: ds
    | Digit.D1 :: ds -> Digit.D0 :: add_1 ds

  let rec add t n =
    if n < 1 then t else add (add_1 t) (n - 1)
end

let () =
  let n = int_of_string Sys.argv.(1) in
  Printf.printf "%s" (Number.to_string (Number.add Number.zero n))
