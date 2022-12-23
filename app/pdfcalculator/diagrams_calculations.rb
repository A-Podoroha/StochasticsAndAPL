require_relative 'randgen.rb'

def calculate_approximation(left, right, k, intervals)
  res = []
  interv_step = (right-left) / intervals

  left.step(right, interv_step) do |i|
    break if (i + interv_step) > right

    new_el = chi_square(k, (2*i+interv_step).to_f / 2.0)
    #(chi_square(k, i + interv_step) - chi_square(k, i)).abs / interv_step
    res << ["(#{i.round(2)}, #{(i + interv_step).round(2)})", new_el]
    #binding.pry
  end

  return res
end

def calculate_frequencies(left, right, intervals, res_rand)
  res = []
  interv_step = (right - left) / intervals

  left.step(right, interv_step) do |i|
    break if i == right

    v_k = res_rand.count {|point| point[0] > i and point[0] < (i + interv_step) }
    res << (v_k.to_f / res_rand.size.to_f)
  end

  res
end

def split_results_by_frequency(left, right, intervals, res_frequency)
  res = []
  interv_step = (right.to_f - left.to_f) / intervals.to_f
  j = 0

  left.step(right, interv_step) do |i|
    break if i == right

    res << ["(#{i.round(2)}, #{(i + interv_step).round(2)})",
          res_frequency[j] / interv_step]
    j += 1

    #binding.pry
  end

  res
end


def calculate_average(arr)
  res = 0.0

  arr.each { |el|
    res += el[0]
    #binding.pry
  }
  res /= arr.size.to_f
  res
end

def calculate_dispersion(arr)
  average_squared2 = calculate_average(arr) ** 2
  arr2 = arr.map {|el| [el[0]**2, el[1]]}
  average_squared1 = calculate_average(arr2)

  average_squared1 - average_squared2
end

def calculate_mode(arr)
  res = {}

  arr.each do |interval|
    res[interval[0].round(3)] ||= 0
    res[interval[0].round(3)] += 1
  end
  ret_value = res.sort_by { |key, value| value }[res.size-1][0]
  ret_value
end
