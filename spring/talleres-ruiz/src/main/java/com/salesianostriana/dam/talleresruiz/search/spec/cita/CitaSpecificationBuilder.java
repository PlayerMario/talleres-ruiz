package com.salesianostriana.dam.talleresruiz.search.spec.cita;

import com.salesianostriana.dam.talleresruiz.models.Cita;
import com.salesianostriana.dam.talleresruiz.search.spec.generic.GenericSpecificationBuilder;
import com.salesianostriana.dam.talleresruiz.search.util.SearchCriteria;

import java.util.List;

public class CitaSpecificationBuilder extends GenericSpecificationBuilder<Cita> {

    public CitaSpecificationBuilder(List<SearchCriteria> params) {
        super(params, Cita.class, Cita.hiddenFields);
    }

}
