import JSON

in_file = "./data/in.json"
out_file = "./data/out.json"
grid_name = "kekw me enjoy"

function get_grid(grids)
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
			"bigger" => true,
			"wide" => 1,
			"mark" => "",
			"heroes" => section["hero_ids"],
		))
	end

	return grid
end

function main()
	json = JSON.parsefile(in_file)

	source = get_grid(json["configs"])
	grid = build(source)

	open(out_file, "w") do f
		JSON.print(f, [ grid ], 2)
	end
end

main()
