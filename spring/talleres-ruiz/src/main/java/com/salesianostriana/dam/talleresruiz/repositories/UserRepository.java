package com.salesianostriana.dam.talleresruiz.repositories;

import com.salesianostriana.dam.talleresruiz.models.dto.user.UserDto;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;
import java.util.UUID;

public interface UserRepository extends JpaRepository<User, UUID>, JpaSpecificationExecutor<User> {

    Optional<User> findFirstByUsername(String username);

    Optional<User> findByDni(String dni);

    boolean existsByEmail(String email);

    boolean existsByTlf(String tlf);

    boolean existsByDni(String dni);

    boolean existsByUsername(String username);

    @Query("""
                 SELECT new com.salesianostriana.dam.talleresruiz.models.dto.user.UserDto(
                     user.id, user.username, user.avatar, user.nombre
                 )
                 FROM User user
                 WHERE user.id = :id
            """)
    UserDto generarUserDto(@Param("id") UUID id);

}
