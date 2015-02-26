# MX::ID

Utilites for validation of Mexican government identifiers.

---

Utilerías para validación de identificadores del gobierno mexicano.

## Why and what for / Por qué y para qué

This gem is conceived as an utility for proyects that involve identifiers issued by the Mexican government to its citizens and organizations.

For example, the R.F.C. (acronym in Spanish for Federal Taxpayer Registry) is an identifier issued by the Ministry of Tresasury and Public Credit for the different kind of taxpayers there is.

This project is not endorsed in any way by the Mexican government.


---

Esta gema está pensada para usarse en proyectos que tienen que ver con las diversas formas en que el gobierno mexicano identifica a ciudadanos y organizaciones.

Por ejemplo, el Registro Federal de Contribuyentes (R.F.C.) es un identificador expedido por la Secretaría de Hacienda y Crédito Público (SHCP) a través del Servicio de Administración Tributaria (SAT) para los distintos tipos de contribuyentes que existen.

Este proyecto no está patrocinado de ninguna forma por el gobierno mexicano. Es un esfuerzo para contribuir a la sanidad mental de los programadores que tenemos que lidiar con estas cosas :)


## Installation / Instalación

Add this line to your application's Gemfile:

```ruby
gem 'mx-id'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mx-id

---

Agrega esta línea al archivo Gemfile de tu aplicación:

```ruby
gem 'mx-id'
```

Luego ejecuta:

    $ bundle

O instálalo tu mismo usando:

    $ gem install mx-id


## Usage / Uso

### R.F.C. (Registro Federal de Contribuyentes)


El Registro Federal de Contribuyentes (R.F.C.) es un identificador expedido por la Secretaría de Hacienda y Crédito Público (SHCP) a través del Servicio de Administración Tributaria (SAT) para los distintos tipos de contribuyentes que existen. Este identificador se encuentra en la Cédula de Identificación Fiscal que el SAT expide al inscribirse en este registro.

El algoritmo aquí implementado para generar y validar un R.F.C. ha salido de varias fuentes en la red, pues al parecer el algoritmo para calcularlo ha cambiado con el paso del tiempo. Estas son algunas de los cambios que he notado:

1. para personas morales registradas antes y después de 1998

Pendiente...


## Contributing / Contribuir

1. Fork it ( https://github.com/Maquech/MX-ID/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

You can also submit technical observations on the algorithms here implemented alongside with references to official documentation that supports it.

---

Puedes contribuir mandándonos tus observaciones sobre la implementación de los algoritmos aquí implementados o referencias a documentos oficiales que las respalde.

Ahora, diviérte con esta traducción (si sabes el término correcto en español, háznoslo saber por favor):

1. Crea tu copia del repositorio ( https://github.com/Maquech/MX-ID/fork )
2. Crea tu rama con la funcionalidad propuesta (`git checkout -b mi-nueva-funcionalidad-shubiduby`)
3. Compromete tus cambios (`git commit -am 'Nueva funcionalidad shubiduby'`)
4. Empuja la rama a tu repositorio (`git push origin mi-nueva-funcionalidad-shubiduby`)
5. Crea una nueva petición de jalada|tirada|extracción|acarreo


## Docs

Use `bundle exec yard server --port 8828 --reload` para generar la documentación. También revisa las [referencias](REFERENCIAS.md)


## Code status / Estado del código

[![Build Status][Travis-CI-badge]][Travis-CI-url] [![Code Climate][Code Climate-badge]][Code Climate-url] [![Coverage Status][Coveralls-badge]][Coveralls-url]
[![Gem Version][gem-badge]][gem-url]

[Travis-CI-badge]: https://travis-ci.org/Maquech/MX-ID.svg?branch=master
[Travis-CI-url]: https://travis-ci.org/Maquech/MX-ID
[Code Climate-badge]: https://codeclimate.com/github/Maquech/MX-ID/badges/gpa.svg
[Code Climate-url]: https://codeclimate.com/github/Maquech/MX-ID
[Coveralls-badge]: https://coveralls.io/repos/Maquech/MX-ID/badge.svg?branch=master
[Coveralls-url]: https://coveralls.io/r/Maquech/MX-ID?branch=master
[gem-badge]: https://badge.fury.io/rb/MX-ID.svg
[gem-url]: http://badge.fury.io/rb/MX-ID
