def chi_square(k, x) # k - degrees of freedom
  return 0 if(x <= 0)
  1 / ((2 ** (k/2)) * Math.gamma(k/2)) * x **(k/2-1) * Math.exp(-x/2)
end

def pdf_calc(k, left, right, n)
  step = (right - left) / n
  res = []

  left.step(right, step) do |xi|
    y = chi_square(k, xi)

    res << [xi, y]
  end

  res
end


def neumann_method(a, b, w, k)
  while true
    r1 = rand
    r2 = rand

    x = a + (b - a) * r1
    y = w * r2

    return [x,y] if chi_square(k, x) > y
  end
end

def n_values_neuman(a, b, k, n)
  w = -100000
  step = 0.00001
  x = a
  while x <= b
    y = chi_square(k, x)

    w = y if y > w
    x += step
  end

  res = Array.new
  n.times do
    res << neumann_method(a, b, w, k)
  end
  res
end


def metropolis_method(l, r, k, times = 1000)
  x0 = l + (r - l) * rand

  (times+1).times do
    x_next = x0 + (-1 + 2 * rand) * (r - l) * 0.1

    a = (x_next > l and x_next < r)?
          chi_square(k, x_next) / chi_square(k, x0) : 0

    if a >= 1
      x0 = x_next
    elsif rand < a
      x0 = x_next
    end
  end
  return [x0, chi_square(k, x0)]
end

def n_values_metropolis(l, r, k, times, n)
  res = []
  n.times do
    res << metropolis_method(l, r, k, times)
  end
  res
end
