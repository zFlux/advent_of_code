def move_projectile (x, y, vel_x, vel_y)
  if vel_x > 0
    vel_x_incr = -1
  elsif vel_x < 0
    vel_x_incr = 1
  else
    vel_x_incr = 0
  end
  [x + vel_x, y + vel_y, vel_x + vel_x_incr, vel_y - 1]
end

def test_projectile (start_x, start_y, init_vel_x, init_vel_y, range_x, range_y)
  x = start_x; y= start_y; vel_x = init_vel_x; vel_y = init_vel_y
  max_y = 0

  while true do
    (x, y, vel_x, vel_y) = move_projectile(x, y, vel_x, vel_y)
    max_y = [y, max_y].max

    if x > range_x.last || y < range_y.first
      return -1
    end

    if x.between?(range_x.first, range_x.last) &&  y.between?(range_y.first, range_y.last)
      return max_y
    end
  end

end

def challenge_1
  maxy = 0
  for vy in (-500..500) do
    for vx in (1..500) do
      result = test_projectile(0,0,vx,vy, [128,160], [-142,-88])
      maxy = [result, maxy].max
    end
  end

  puts "Max Y: " + maxy.to_s
end

challenge_1