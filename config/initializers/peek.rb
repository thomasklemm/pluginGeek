if Rails.env.development?
  Peek.into Peek::Views::Git
end

Peek.into Peek::Views::PG
Peek.into Peek::Views::Dalli
Peek.into Peek::Views::PerformanceBar

