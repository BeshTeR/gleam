/// Точка входа для тестирования
import gleam/io

import algorithms

pub fn main() {
  let res = algorithms.pow(1024, 100)
  io.debug(res)
}
