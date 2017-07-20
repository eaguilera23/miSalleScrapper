require 'date'
module PagosHelper
  module_function

  def agregar_pagos
    Pago.create(fecha: Date.new(2017, 8, 11))
    Pago.create(fecha: Date.new(2017, 9, 11))
    Pago.create(fecha: Date.new(2017, 10, 10))
    Pago.create(fecha: Date.new(2017, 11, 4))
  end
end
