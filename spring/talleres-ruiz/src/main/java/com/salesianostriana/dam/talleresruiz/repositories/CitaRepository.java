package com.salesianostriana.dam.talleresruiz.repositories;

import com.salesianostriana.dam.talleresruiz.models.Cita;
import com.salesianostriana.dam.talleresruiz.models.Mecanico;
import com.salesianostriana.dam.talleresruiz.models.dto.cita.CitaDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface CitaRepository extends JpaRepository<Cita, Long>, JpaSpecificationExecutor<Cita> {

    List<Cita> findByMecanico(Mecanico mecanico);

    @Query("""
                 SELECT cita
                 FROM Cita cita LEFT JOIN FETCH cita.chat
                 WHERE cita.id = :id 
            """)
    Optional<Cita> findByIdChat(@Param("id") Long id);

    List<Cita> findDistinctByMecanicoAndFechaHora(Mecanico mec, LocalDateTime fechaHora);
}
