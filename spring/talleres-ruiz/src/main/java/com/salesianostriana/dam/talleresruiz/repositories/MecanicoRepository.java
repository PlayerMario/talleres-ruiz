package com.salesianostriana.dam.talleresruiz.repositories;

import com.salesianostriana.dam.talleresruiz.models.Mecanico;
import com.salesianostriana.dam.talleresruiz.models.dto.mecanico.MecanicoDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.UUID;

public interface MecanicoRepository extends JpaRepository<Mecanico, UUID>, JpaSpecificationExecutor<Mecanico> {

    @Query("""
                 SELECT new com.salesianostriana.dam.talleresruiz.models.dto.mecanico.MecanicoDto(
                     usuario.id, usuario.nombre, usuario.username, usuario.dni, usuario.email, usuario.tlf, usuario.avatar
                 )
                 FROM Mecanico mecanico LEFT JOIN mecanico.usuario usuario
                 WHERE mecanico.id = :id
            """)
    MecanicoDto generarMecanicoDto(@Param("id") UUID id);

    @Query("""
                SELECT DISTINCT mecanico
                FROM Mecanico mecanico LEFT JOIN mecanico.usuario usuario
                WHERE usuario.nombre = :nombre
           """)
    Mecanico findByNombre(@Param("nombre") String nombre);

}
