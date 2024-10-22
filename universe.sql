psql --username=freecodecamp --dbname=postgres

\c universe

CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    size INT NOT NULL,
    distance_from_earth NUMERIC(10, 2) NOT NULL,
    is_spiral BOOLEAN NOT NULL DEFAULT false,
    description TEXT
);

CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    temperature INT NOT NULL,
    brightness NUMERIC(10, 2) NOT NULL,
    is_visible BOOLEAN NOT NULL DEFAULT true,
    galaxy_id INT NOT NULL,
    FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id) ON DELETE CASCADE
);

CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    mass INT NOT NULL,
    distance_from_star NUMERIC(10, 2) NOT NULL,
    has_ring BOOLEAN NOT NULL DEFAULT false,
    star_id INT NOT NULL,
    FOREIGN KEY (star_id) REFERENCES star(star_id) ON DELETE CASCADE
);

CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    diameter INT NOT NULL,
    distance_from_planet NUMERIC(10, 2) NOT NULL,
    is_inhabitable BOOLEAN NOT NULL DEFAULT false,
    planet_id INT NOT NULL,
    FOREIGN KEY (planet_id) REFERENCES planet(planet_id) ON DELETE CASCADE
);

CREATE TABLE satellite (
    satellite_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    launch_year INT,
    is_artificial BOOLEAN NOT NULL DEFAULT true,
    planet_id INT NOT NULL,
    FOREIGN KEY (planet_id) REFERENCES planet(planet_id) ON DELETE CASCADE
);

INSERT INTO galaxy (name, size, distance_from_earth, is_spiral, description) VALUES
('Milky Way', 100000, 0.0, true, 'A spiral galaxy containing our solar system.'),
('Andromeda', 220000, 2.537, true, 'The nearest major galaxy to the Milky Way.'),
('Triangulum', 60000, 3.14, true, 'The third-largest member of the Local Group.')
ON CONFLICT (name) DO NOTHING;

INSERT INTO star (name, temperature, brightness, galaxy_id, is_visible) VALUES
('Sun', 5778, 1.0, 1, true),
('Sirius', 9940, 25.4, 1, true),
('Proxima Centauri', 3050, 0.0017, 1, false)
ON CONFLICT (name) DO NOTHING;

INSERT INTO planet (name, mass, distance_from_star, star_id, has_ring) VALUES
('Earth', 5972, 1.0, 1, false),
('Mars', 641, 1.52, 1, false),
('Jupiter', 1898200, 5.20, 1, true)
ON CONFLICT (name) DO NOTHING;

INSERT INTO moon (name, diameter, distance_from_planet, planet_id, is_inhabitable) VALUES
('Moon', 3475, 384400, 1, false),
('Phobos', 22.4, 9377, 2, false),
('Deimos', 12.4, 23459, 2, false)
ON CONFLICT (name) DO NOTHING;

INSERT INTO satellite (name, launch_year, is_artificial, planet_id) VALUES
('Sputnik', 1957, true, 1),
('Voyager 1', 1977, true, 1),
('Hubble Space Telescope', 1990, true, 1)
ON CONFLICT (name) DO NOTHING;


