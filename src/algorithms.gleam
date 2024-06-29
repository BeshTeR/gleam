//// Реализация некоторых алгоритмов
//// Oleg Muraviev <avesh.net@bk.ru>

import gleam/float
import gleam/int
import gleam/io
import gleam/list
import gleam/result

/// ----------------------------------------------------------------------------
/// FizzBuzz
pub fn fizz_buzz() {
  fizz_buzz_loop(1)
}

const max_fizz_buzz = 100

fn fizz_buzz_loop(n: Int) {
  case n <= max_fizz_buzz {
    True -> {
      let res = case n % 3, n % 5 {
        0, 0 -> "FizzBuzz"
        0, _ -> "Fizz"
        _, 0 -> "Buzz"
        _, _ -> int.to_string(n)
      }
      io.println(res)
      fizz_buzz_loop(n + 1)
    }
    False -> Nil
  }
}

/// ----------------------------------------------------------------------------
/// Числа Фибоначчи
/// С ростом N затраты времени на вычисления растут логарифмически.
/// Если A и B - пара соседних чисел Фибоначчи, то трансформации на каждой 
/// итерации при переходе к следующей паре:
/// A ← B*Q+A*Q+A*P
/// B ← B*P+A*Q
/// где P и Q - коэффициенты трансформации
pub fn fib(n: Int) -> Int {
  case n >= 0 {
    True -> fib_loop(n, 1, 0, 0, 1)
    False -> 0
  }
}

fn fib_loop(n, a, b, p, q: Int) -> Int {
  case int.is_even(n) {
    _ if n == 0 -> b
    True -> fib_loop(n / 2, a, b, p * p + q * q, 2 * p * q + q * q)
    False -> fib_loop(n - 1, b * q + a * q + a * p, b * p + a * q, p, q)
  }
}

/// ----------------------------------------------------------------------------
/// Быстрое возведение числа в степень по инвариантам:
/// N ^ M = (N ^ (M / 2)) ^ 2 - если M четно
/// N ^ M = N * (N ^ (M - 1)) - если M нечетно
/// N, M - натуральные числа
pub fn pow(n, m: Int) -> Int {
  case n >= 1 || m >= 0 {
    True -> pow_loop(n, m, 1)
    False -> 0
  }
}

fn pow_loop(n, m, acc: Int) -> Int {
  case m % 2, m {
    _, 0 -> acc
    0, _ -> pow_loop(n * n, m / 2, acc)
    _, _ -> pow_loop(n, m - 1, n * acc)
  }
}

/// ----------------------------------------------------------------------------
/// Наибольший общий делитель двух цулых чисел
pub fn gcd(n, m: Int) -> Int {
  case m {
    0 -> int.absolute_value(n)
    _ -> gcd(m, n % m)
  }
}

/// ----------------------------------------------------------------------------
/// Пифагоровы тройки со сторонами треугольника не больше заданного натурального числа
pub fn pythag(n: Int) -> List(#(Int, Int, Int)) {
  pythag_make(n, n - 1, [])
  |> list.filter(fn(x) {
    x.2 <= n && x.0 * x.0 + x.1 * x.1 == x.2 * x.2 && gcd(x.0, x.1) == 1
  })
}

fn pythag_make(a, b: Int, res: List(#(Int, Int, Int))) -> List(#(Int, Int, Int)) {
  let c =
    a * a + b * b
    |> int.square_root()
    |> result.unwrap(0.0)
    |> float.round()

  case a < 4, b < 3 {
    True, _ -> res
    False, True -> pythag_make(a - 1, a - 2, [#(b, a, c), ..res])
    False, False -> pythag_make(a, b - 1, [#(b, a, c), ..res])
  }
}

/// ----------------------------------------------------------------------------
/// Проверка числа на простоту
pub fn is_prime(n: Int) -> Bool {
  case n % 2 {
    _ if n < 0 -> is_prime(-n)
    _ if n < 2 -> False
    0 -> n == 2
    _ -> is_prime_loop(n, 3)
  }
}

fn is_prime_loop(n, acc: Int) -> Bool {
  case acc * acc > n {
    True -> True
    False ->
      case n % acc {
        0 -> False
        _ -> is_prime_loop(n, acc + 2)
      }
  }
}

/// ----------------------------------------------------------------------------
/// Разложение натурального числа на простые множители
pub fn factors(n: Int) -> List(Int) {
  case n {
    _ if n <= 1 -> []
    _ -> list.reverse(factors_loop(n, #(2, [])))
  }
}

fn factors_loop(n: Int, res: #(Int, List(Int))) -> List(Int) {
  let #(m, ls) = res
  let p = m * m
  let q = n % m
  case p > n, q {
    True, _ -> [n, ..ls]
    False, 0 -> factors_loop(n / m, #(m, [m, ..ls]))
    False, _ -> factors_loop(n, #(m + 1, ls))
  }
}

/// ----------------------------------------------------------------------------
/// Список простых чисел меньших или равных заданному натуральному числу
pub fn primes(n: Int) -> List(Int) {
  todo
  // list(1) ->
  //  [];
  // list(N) when is_integer(N), N > 1 ->
  //  Set = ordsets:from_list(lists:seq(3, N, 2)),
  //  ordsets:add_element(2, sieve(N, Set, Set, ordsets:new())).
  //
  // sieve(_, Set1, Set2, Primes) when length(Set2) =:= 0 ->
  //  ordsets:union(Primes, Set1);
  // sieve(N, Set1, Set2, Primes) ->
  //  H = lists:nth(1,string:substr(Set1, 1, 1)),
  //  {R1, R2} = remove_multiples_of(H, ordsets:del_element(H, Set1), Set2),
  //  sieve(N, R1, R2, ordsets:add_element(H, Primes)).
  //
  // remove_multiples_of(N, Set1, Set2) ->
  //  NewSet = ordsets:filter(fun(X) -> X >= N*N end, Set2),
  //  R = ordsets:filter(fun(X) -> X rem N =:= 0 end, NewSet),
  //  {ordsets:subtract(Set1, R), ordsets:subtract(NewSet, R)}.
}
/// ----------------------------------------------------------------------------
