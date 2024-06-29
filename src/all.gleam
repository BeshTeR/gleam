/// Точка входа для тестирования
import gleam/io

import algorithms

pub fn main() {
  let res = algorithms.factors(127)
  io.debug(res)
}
