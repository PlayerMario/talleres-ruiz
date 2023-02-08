package com.salesianostriana.dam.talleresruiz.repositories;

import com.salesianostriana.dam.talleresruiz.models.Mecanico;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface MecanicoRepository extends JpaRepository<Mecanico, Long>, JpaSpecificationExecutor<Mecanico> {
}
