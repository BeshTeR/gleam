/// Точка входа для тестирования
import gleam/io

import algorithms

pub type DateTime

@external(erlang, "calendar", "local_time")
pub fn now() -> DateTime

pub fn main() {
  // io.debug(now())
  algorithms.factors(111 * 127 * 12)
  |> io.debug()
}
