-- Пользователи
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(40),
    telegram_id VARCHAR(12)
);

-- Группа мышц
CREATE TABLE muscle_group (
    id   BIGSERIAL PRIMARY KEY,
    name TEXT      NOT NULL
);

-- Тренажеры
CREATE TABLE machine (
    id   BIGSERIAL PRIMARY KEY,
    name TEXT      NOT NULL,
    description TEXT,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Изображения тренажеров
CREATE TABLE machine_image (
    id   BIGSERIAL PRIMARY KEY,
    machine_id BIGINT REFERENCES machines(id) ON DELETE CASCADE,
    image_url VARCHAR(500) NOT NULL,
    alt_text VARCHAR(255),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Упражнения
CREATE TABLE exercise (
    id   BIGSERIAL PRIMARY KEY,
    name TEXT      NOT NULL,
    description TEXT,
    warning TEXT,
    recommended_reps_amount SMALLINT,
    recommended_rest_duration INT,
    is_gym_required BOOLEAN,
    video_tutorial_url VARCHAR(500),
    machine_id BIGINT REFERENCES machines(id) ON DELETE SET NULL,
    muscle_group_id BIGINT REFERENCES muscle_group(id) ON DELETE SET NULL,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Изображения упражнения
CREATE TABLE exercise_image (
    id   BIGSERIAL PRIMARY KEY,
    exercise_id BIGINT REFERENCES exercises(id) ON DELETE CASCADE,
    image_url VARCHAR(500) NOT NULL,
    alt_text VARCHAR(255),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);