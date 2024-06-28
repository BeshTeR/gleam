/// Точка входа для тестирования
import gleam/io

import algorithms

pub fn main() {
  let res = algorithms.is_prime(127)
  io.debug(res)
}
