function player_controller()
	local newx = player.xpos
	local newy = player.ypos

	if (btn(➡️)) newx += player.rate
	if (btn(⬅️)) newx -= player.rate 
    if (btnp(🅾️)) grav_direction = not grav_direction
    if btn(❎) then 
        speed_up = true
    else
        speed_up = false
    end

    local upper_bound = 100
    local lower_bound = 20

    if (newx <= upper_bound and
        newx >= lower_bound) then
        player.xpos = newx
        player.ypos = newy

        -- Update Collider
        player.collider:update(
            player.xpos,
            player.ypos
        )
    end



end

function test_collision(collider1, collider2)
    -- Nerdyteachers collider tester
    -- Return true on collision
    return collider1.x < collider2.x+collider2.width and
    collider1.x+collider1.width > collider2.x and
    collider1.y < collider2.y+collider2.height and
    collider1.y+collider.height > collider2.y
end

