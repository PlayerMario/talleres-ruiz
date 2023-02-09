package com.salesianostriana.dam.talleresruiz.repositories;

import com.salesianostriana.dam.talleresruiz.models.Mecanico;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.UUID;

public interface MecanicoRepository extends JpaRepository<Mecanico, UUID>, JpaSpecificationExecutor<Mecanico> {
}
