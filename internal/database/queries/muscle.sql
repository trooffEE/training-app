-- name: GetMuscleGroup :one
SELECT * FROM muscle_group WHERE id = $1 LIMIT 1;

-- name: ListMuscleGroup :many
SELECT * FROM muscle_group;

-- name: CreateMuscleGroup :one
INSERT INTO muscle_group (name) VALUES ($1) RETURNING *;

-- name: UpdateMuscleGroup :one
UPDATE muscle_group SET name = $2 WHERE id = $1 RETURNING *;

-- name: DeleteMuscleGroup :exec
DELETE FROM muscle_group WHERE id = $1;