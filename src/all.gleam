/// Точка входа для тестирования
import gleam/io

import algorithms

pub fn main() {
  let res = algorithms.pow(2, 10_000)
  io.debug(res)
}
