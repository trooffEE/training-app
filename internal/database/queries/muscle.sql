-- name: GetMuscleGroup :one
SELECT * FROM muscle_groups WHERE id = $1 LIMIT 1;

-- name: ListMuscleGroup :many
SELECT * FROM muscle_groups;

-- name: CreateMuscleGroup :one
INSERT INTO muscle_groups (name) VALUES ($1) RETURNING *;

-- name: UpdateMuscleGroup :one
UPDATE muscle_groups SET name = $2 WHERE id = $1 RETURNING *;

-- name: DeleteMuscleGroup :exec
DELETE FROM muscle_groups WHERE id = $1;