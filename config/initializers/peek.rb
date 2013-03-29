if Rails.env.development?
  Peek.into Peek::Views::Git
end

Peek.into Peek::Views::PerformanceBar
Peek.into Peek::Views::PG
Peek.into Peek::Views::Dalli

