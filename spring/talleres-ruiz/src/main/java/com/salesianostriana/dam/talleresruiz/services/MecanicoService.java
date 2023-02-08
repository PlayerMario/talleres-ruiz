package com.salesianostriana.dam.talleresruiz.services;

import com.salesianostriana.dam.talleresruiz.repositories.MecanicoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MecanicoService {

    private final MecanicoRepository repository;

}
