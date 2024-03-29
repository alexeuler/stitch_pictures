module Enums
  FABRICS = %w(BSH498 BSH499 BSH500 BSH506 BSH509 BSH539 BSH540 BSH541
  BSH542 BSH549 BSH550 BSH555 BSH556 BSH568 BSH569 BSH570 BSH573
  BSH574 BSH576 BSH581 BSH582 BSHA01 BSHA02 BSHA03 BSHE00 BSHG92
  BSHH17 BSHH18 BSHH29 BSHH52 BSHH84 BSHH88 BSHH89 BSHH92 BSHH94
  BSHH95 BSHH97 BSHH98 BSHH99 BSHK00 BSHK01 BSHK02 BSHK03 OSDS_TC32
  OSDS_TC33 OSDS_TC34 OSDS_TC35 OSDS_TC49 OSDS_TC50 OSDS_TC51
  OSDS_TC52 OSDS_TC53 OSDS_TC54 OSDS_TC55 OSDS_TC56 OSDS_TC58
  OSDS_TF01 OSDS_TF02 OSDS_TF03 OSDS_TF04 OSDS_TF05 OSDS_TF07
  OSDS_TF08 OSDS_TF09 OSDS_TF10 OSDS_TF11 OSDS_TF13 OSDS_TF14
  OSDS_TF15 OSDS_TF16 OSDS_TF17 OSDS_TF19 OSDS_TF20 OSDS_TF21
  OSDS_TF22 OSDS_TF24 OSDS_TF25 OSDS_TF26 OSDS_TF27 OSDS_TF28
  OSDS_TF29 OSDS_TF30 OSDS_TF31 OSDS_TF32 OSDS_TF33 OSDS_TF34
  OSDS_TF36 OSDS_TF37 OSDS_TF39 OSDS_TF41 OSDS_TF42 OSDS_TF43
  OSDS_TF44 OSDS_TF45 OSDS_TF56 OSDS_TF58 OSDS_TU03 OSDS_TU04
  OSDS_TU05 OSDS_TU06 OSDS_TU07 OSDS_TU08 OSDS_TU09 OSDS_TU10
  OSDS_TU11 OSDS_TU12 OSDS_TU13 OSDS_TU14 OSDS_TU15 OSDS_TU16
  OSDS_TU17 OSDS_TU18 OSDS_TU19 OSDS_TU20 OSDS_TU21 OSDS_TU22
  OSDS_TU23 OSDS_TU26 OSDS_TU27 OSDS_TU28 OSDS_TU29 OSDS_TU30
  OSDS_TU31 OSDS_TU32 OSDS_TU33)

  VIEWS = %w(front left back right)

  ITEMS = {
      cuffs: {
          type: %w(round angle big_round big_angle square french),
          sub_type: %w(slim inner)
      },
      collar: {
          type: %w(regular low_semi_wide wide_spread cut_away big_round stand),
          sub_type: ["", "inner"]
      },
      sleeves: {
          type: %w(long short),
          sub_type: ["slim"]
      },
      base: {
          type: %w(slim placket_inner_slim),
          sub_type: [""]
      },
  }

  BUTTONS = {
      color: %w(white purple brown gray darkgray winered saxeblue pink navy),
      type: %w(cuffs collar_one_button base_slim)
  }

  class Buttons
    include Enumerable

    def each(&block)
      VIEWS.each do |view|
        BUTTONS[:color].each do |color|
          BUTTONS[:type].each do |type|
            block.call("buttons/#{color}/#{view}/buttons_#{type}")
          end
        end
      end
    end
  end

  class Items
    include Enumerable

    def initialize(item)
      @item = item.to_sym
      @hash = ITEMS[@item]
    end

    def each(&block)
      @hash[:type].each do |type|
        @hash[:sub_type].each do |sub_type|
          res = "#{@item}_#{type}"
          res += "_#{sub_type}" unless (sub_type.empty? ||
              type == "french" && sub_type == "slim") #exception of rule
          block.call(res)
        end
      end
    end
  end
end