package com.salesianostriana.dam.talleresruiz.repositories;

import com.salesianostriana.dam.talleresruiz.models.user.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.Optional;
import java.util.UUID;

public interface UserRepository extends JpaRepository<User, UUID>, JpaSpecificationExecutor<User> {

    Optional<User> findFirstByUsername(String username);

    boolean existsByEmail(String email);

    boolean existsByTlf(String tlf);
}
