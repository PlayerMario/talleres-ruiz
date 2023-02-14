package com.salesianostriana.dam.talleresruiz.repositories;

import com.salesianostriana.dam.talleresruiz.models.Cliente;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ClienteRepository extends JpaRepository<Cliente, UUID>, JpaSpecificationExecutor<Cliente> {
    boolean existsByMatricula(String matricula);

    @Query("""
               SELECT cliente
               FROM Cliente cliente LEFT JOIN FETCH cliente.citas
               WHERE cliente.id = :id
           """)
    Optional<Cliente> findByIdCitas(@Param("id")UUID id);

}
