package com.salesianostriana.dam.talleresruiz.repositories;

import com.salesianostriana.dam.talleresruiz.models.Mensaje;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface MensajeRepository extends JpaRepository<Mensaje, Long>, JpaSpecificationExecutor<Mensaje> {
}
