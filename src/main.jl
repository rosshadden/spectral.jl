import JSON

out_file = Base.@__DIR__() * "/../data/out.json"

function get_grid(grids, grid_name)
	for grid in grids
		if grid["config_name"] == grid_name
			return grid
		end
	end
end

function build(source)
	grid = Dict{String, Any}(
		"name" => source["config_name"],
		"tag" => "smile",
		"categories" => Any[],
	)

	for section in source["categories"]
		push!(grid["categories"], Dict(
			"name" => section["category_name"],
			"nameType" => 0,
			"bigger" => false,
			"wide" => 1,
			"mark" => "",
			"heroes" => section["hero_ids"],
		))
	end

	return grid
end

function main(in_file, grid_name)
	json = JSON.parsefile(in_file)

	source = get_grid(json["configs"], grid_name)
	grid = build(source)

	open(out_file, "w") do f
		JSON.print(f, [ grid ], 2)
	end
end

main(ARGS[1], ARGS[2])
