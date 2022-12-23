require_relative '../../app/pdfcalculator/randgen.rb'
require_relative '../../app/pdfcalculator/diagrams_calculations.rb'
class PagesController < ApplicationController
  def home
    left = 0.01
    right = 8.0
    k = 4.0
    times_calculate = 100000
    intervals = 15.0

    @neumann_calculations1 = n_values_neuman(left, right, k, times_calculate)
                                    .sort {|a, b| a[0] <=> b[0]}
    @neumann_calculations2 = n_values_neuman(left, right, k, times_calculate)
                                    .sort {|a, b| a[0] <=> b[0]}
    @result_frequency1 = calculate_frequencies(left, right,
                                intervals, @neumann_calculations1)
    @ser1_neumann = split_results_by_frequency(left, right,
                                intervals, @result_frequency1)
    @result_frequency2 = calculate_frequencies(left, right,
                                intervals, @neumann_calculations2)
    @ser2_neumann = split_results_by_frequency(left, right,
                                intervals, @result_frequency2)


    @metropolis1 = n_values_metropolis(left, right, k, 100, times_calculate)
    @metropolis2 = n_values_metropolis(left, right, k, 100, times_calculate)
    @result_frequency_metr1 = calculate_frequencies(left, right,
                                intervals, @metropolis1)
    @ser1_metropolis = split_results_by_frequency(left, right,
                                intervals, @result_frequency_metr1)

    @result_frequency_metr2 = calculate_frequencies(left, right,
                                intervals, @metropolis2)
    @ser2_metropolis = split_results_by_frequency(left, right,
                                intervals, @result_frequency_metr2)

    @approximation = calculate_approximation(left, right, k, intervals)

    @avg_theor = k
    @avg_n1 = calculate_average(@neumann_calculations1)
    @avg_n2 = calculate_average(@neumann_calculations2)
    @avg_m1 = calculate_average(@metropolis1)
    @avg_m2 = calculate_average(@metropolis2)
    @disp_theor = 2*k
    @disp_n1 = calculate_dispersion(@neumann_calculations1)
    @disp_n2 = calculate_dispersion(@neumann_calculations2)
    @disp_m1 = calculate_dispersion(@metropolis1)
    @disp_m2 = calculate_dispersion(@metropolis2)
    @mode_theor = [k-2, 0].max
    @mode_n1 = calculate_mode(@neumann_calculations1)
    @mode_n2 = calculate_mode(@neumann_calculations2)
    @mode_m1 = calculate_mode(@metropolis1)
    @mode_m2 = calculate_mode(@metropolis2)

    #@pdf_builder = pdf_calc(k, left,right, times_calculate)
  end
  # @neumann = []
  # current_x = left
  # step = 0.1
  # prev_x = -1000
  # while current_x <= right
  #   candidates = @neumann_calculations.select { |a| a[0] <= current_x and
  #                                                   a[0] > prev_x }
  #   res = candidates.max { |a, b| a[1] > b[1] }
  #   current_x += step
  #   next if res == nil
  #   prev_x = res[0]
  #   @neumann << res
  # end

  # current_x = left
  # step = 0.1
  # prev_x = -1
  # while current_x <= right
  #   candidates = @metropolis_calculations.select { |a| a[0] <= current_x and
  #                                                   a[0] > prev_x }
  #   res = candidates.max { |a, b| a[1] <=> b[1] }
  #   current_x += step
  #   next if res == nil
  #   prev_x = res[0]
  #   @metropolis_graphics << res
  # end


  def about
  end

  def manual
  end

end
