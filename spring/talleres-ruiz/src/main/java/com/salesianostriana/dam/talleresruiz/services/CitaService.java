package com.salesianostriana.dam.talleresruiz.services;

import com.salesianostriana.dam.talleresruiz.repositories.CitaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CitaService {

    private final CitaRepository repository;

}
