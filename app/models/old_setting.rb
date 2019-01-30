class OldSetting < OldRecord
  self.table_name = :settings

  def self.to_new
    [:notes, :export_path, :name, [:opening_time, :opening], [:closing_time, :closing],
     [:recharge_after_day, :recharge_after], :recharge_value,
     [:month_recharge_value, :second_recharge_value], :language, :date_format,
     ].each do |k|
      if k.is_a?(Array)
        k, old_k = k
      else
        old_k = k
      end

      Setting.set(k, find_by(key: old_k).value)
    end

    old_fees = JSON.parse(OldSetting.find_by(key: :fees).value)
    Setting.set(:hour_fees, old_fees)
  end
end
