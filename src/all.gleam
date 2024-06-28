import gleam/io

import algorithms

pub fn main() {
  let res = algorithms.pythag(100)
  io.debug(res)
}
