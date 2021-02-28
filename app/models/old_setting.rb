# frozen_string_literal: true

class OldSetting < OldRecord
  self.table_name = :settings

  def self.to_new
    aux = [
      :notes, :export_path, :name, %i[opening_time opening], %i[closing_time closing],
      %i[recharge_after_day recharge_after], :recharge_value,
      %i[month_recharge_value second_recharge_value], :language, :date_format
    ]
    aux.each do |k|
      if k.is_a?(Array)
        k, old_k = k
      else
        old_k = k
      end

      Setting.set(k, find_by(key: old_k).value)
    end

    old_fees = JSON.parse(find_by(key: :fees).value)
    Setting.set(:hour_fees, old_fees)
  end
end
