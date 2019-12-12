CREATE DATABASE  IF NOT EXISTS `alb123` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `alb123`;
-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: alb123
-- ------------------------------------------------------
-- Server version	5.7.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `categoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Indica el identificador de la tabla, no puede ir vacio y es auto incrementar',
  `nombre` varchar(100) NOT NULL COMMENT 'Indica el nombre de la categoria, es obligatorio',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Esta tabla es de control de las categorias existentes a las cuales categorizan un producto';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'deportivos'),(2,'casual'),(3,'elegante'),(4,'entrenamiento');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credencial`
--

DROP TABLE IF EXISTS `credencial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `credencial` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de credenciales que los diferencia de los demas. Auto incremental y no puede ir vacio.',
  `usuario` varchar(100) NOT NULL COMMENT 'Indica el usuario con el cual se va a ingresar al sistema, es unico y no puede ir vacio.',
  `contrasena` varchar(100) NOT NULL COMMENT 'Indica la contraseña con la cual se va a acceder al sistema, no puede ir vacio, pues se debe conocer.',
  `FechaRegistro` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Indica la fecha en la cual se creó el usuario.',
  `RolId` int(11) NOT NULL COMMENT 'Indica el id de la table de rol. La cual especifica con que rol va a ingresar al sistema y los respectivos permisos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuario_UNIQUE` (`usuario`),
  KEY `fk_credencial_rol1_idx` (`RolId`),
  CONSTRAINT `fk_credencial_rol1` FOREIGN KEY (`RolId`) REFERENCES `rol` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Esta tabla guarda información de las credenciales. Las cuales permitiran identificar el usuario para acceder al sistema.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credencial`
--

LOCK TABLES `credencial` WRITE;
/*!40000 ALTER TABLE `credencial` DISABLE KEYS */;
INSERT INTO `credencial` VALUES (1,'1','muchas12','2019-12-20 05:00:00',1),(2,'2','mas14','2019-12-18 05:00:00',2),(3,'3','calbeiro1','2019-11-19 05:00:00',3);
/*!40000 ALTER TABLE `credencial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `factura` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de factura, que permite diferenciarla de las demas, es auto incrementar y no puede ir vacia',
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Indica la fecha en la cual se registro la factura, se asigna automaticamente al registrarse.',
  `total` float NOT NULL COMMENT 'Indica el valor total de la venta, la suma de el valor de todos los productos y los inpuestos',
  `subtotal` float NOT NULL COMMENT 'Indica el valor neto de la suma de todos los productos, no puede ir vacio',
  `impuestos` float NOT NULL COMMENT 'Indica el valor del impuesto aplicado a la venta',
  `VendedorId` int(11) NOT NULL COMMENT 'Indica el id del vendedor el cual contiene toda su información de la tabla registros. ',
  `TipoPagoId` int(11) NOT NULL COMMENT 'indica el tipo de pago realizado, es el id proveniente de la tabla tipo de pagos',
  PRIMARY KEY (`id`),
  KEY `fk_data_idx` (`VendedorId`),
  KEY `fk_factura_tipo_pago1_idx` (`TipoPagoId`),
  CONSTRAINT `fk_data` FOREIGN KEY (`VendedorId`) REFERENCES `registro` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_factura_tipo_pago1` FOREIGN KEY (`TipoPagoId`) REFERENCES `tipopago` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Permite guardar la información de la factura de las ventas realizadas.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura`
--

LOCK TABLES `factura` WRITE;
/*!40000 ALTER TABLE `factura` DISABLE KEYS */;
INSERT INTO `factura` VALUES (1,'2019-12-10 05:00:00',153000,150000,2,2,3),(2,'2019-12-15 05:00:00',91800,90000,2,1,1);
/*!40000 ALTER TABLE `factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordencompra`
--

DROP TABLE IF EXISTS `ordencompra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ordencompra` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id de la orden, no pueden ir vacio, es necesario conocer a que orden de compra se relacionan los productos',
  `ProvedorId` int(11) NOT NULL COMMENT 'en este campo se encuentra la identificacion del provedor al cual se le genero la compra',
  `fecha` timestamp NOT NULL COMMENT 'en esta columna se registra la fecha en la que se genera el pedido',
  `observaciones` varchar(500) DEFAULT NULL COMMENT 'este campo se utiliza para notificar tipos de novedades que se presenten, como cambio de direccion o de numeros de contacto.',
  `PrecioTotal` float NOT NULL COMMENT 'en esta columna se registra el precio total de la compra realizada',
  PRIMARY KEY (`id`),
  KEY `fk_orden_compra_proveedor1_idx` (`ProvedorId`),
  CONSTRAINT `fk_orden_compra_proveedor1` FOREIGN KEY (`ProvedorId`) REFERENCES `proveedor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Indica la relacion de una orden de compra y los productos que se solicitan en la respectiva orden';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordencompra`
--

LOCK TABLES `ordencompra` WRITE;
/*!40000 ALTER TABLE `ordencompra` DISABLE KEYS */;
INSERT INTO `ordencompra` VALUES (1,2,'2019-12-05 05:00:00','numero de contacto nuevo 112114',1500000),(3,1,'2019-12-01 05:00:00','se adquieren 20 zapatos',1800000);
/*!40000 ALTER TABLE `ordencompra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordencomprayproducto`
--

DROP TABLE IF EXISTS `ordencomprayproducto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ordencomprayproducto` (
  `OrdenCompraId` int(11) NOT NULL COMMENT 'Id de la orden, no pueden ir vacio, es necesario conocer a que orden de compra se relacionan los productos',
  `ProductosId` int(11) NOT NULL COMMENT 'Indica el id del producto que se solicita a la respectiva orden',
  `cantidad` int(11) NOT NULL COMMENT 'Indica la cantidad del producto que se solicita',
  PRIMARY KEY (`OrdenCompraId`,`ProductosId`),
  KEY `fk_orden_compra_has_productos_productos1_idx` (`ProductosId`),
  KEY `fk_orden_compra_has_productos_orden_compra1_idx` (`OrdenCompraId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Indica la relacion de una orden de compra y los productos que se solicitan en la respectiva orden';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordencomprayproducto`
--

LOCK TABLES `ordencomprayproducto` WRITE;
/*!40000 ALTER TABLE `ordencomprayproducto` DISABLE KEYS */;
INSERT INTO `ordencomprayproducto` VALUES (1,1,15),(2,2,20);
/*!40000 ALTER TABLE `ordencomprayproducto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permisos`
--

DROP TABLE IF EXISTS `permisos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `permisos` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla, no puede ir vacio y es auto incrementar.',
  `nombre` varchar(100) NOT NULL COMMENT 'Indica el nombre del correspondiente permiso. No puede ir vacio.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Guarda los permisos disponibles, las cosas que se pueden realizar en el sistema.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permisos`
--

LOCK TABLES `permisos` WRITE;
/*!40000 ALTER TABLE `permisos` DISABLE KEYS */;
INSERT INTO `permisos` VALUES (1,'administrador'),(2,'caja'),(3,'bodega'),(4,'ventas');
/*!40000 ALTER TABLE `permisos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permisosrol`
--

DROP TABLE IF EXISTS `permisosrol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `permisosrol` (
  `RolId` int(11) NOT NULL COMMENT 'Id de la tabla rol. No puede ir vacio.',
  `PermisosId` int(11) NOT NULL COMMENT 'Id que especifica el permiso, no puede ir vacio.',
  PRIMARY KEY (`RolId`,`PermisosId`),
  KEY `fk_rol_has_permisos_permisos1_idx` (`PermisosId`),
  KEY `fk_rol_has_permisos_rol1_idx` (`RolId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Es la tabla intermedia, que permite especificar que permisos tiene un rol y asi mismo que roles tiene un permiso.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permisosrol`
--

LOCK TABLES `permisosrol` WRITE;
/*!40000 ALTER TABLE `permisosrol` DISABLE KEYS */;
INSERT INTO `permisosrol` VALUES (1,1),(2,2),(3,3);
/*!40000 ALTER TABLE `permisosrol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preguntasseguridad`
--

DROP TABLE IF EXISTS `preguntasseguridad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `preguntasseguridad` (
  `IDPregunta` int(11) NOT NULL COMMENT 'esta columna identifica la pregunta que se realiza para recordar la contraseña',
  `Pregunta` varchar(45) DEFAULT NULL COMMENT 'Esta columna hace referencia a las preguntas de seguridad que se generan para recordar la contraseña',
  `Respuesta` varchar(45) DEFAULT NULL COMMENT 'En esta columna se guardaran las respuestas de cada usuario al crear una contraseña',
  `CredencialId` int(11) NOT NULL COMMENT 'esta columna relaciona el usuario que va a recordar la contraseña',
  PRIMARY KEY (`IDPregunta`,`CredencialId`),
  KEY `fk_PreguntasDeSeguridad_credencial1_idx` (`CredencialId`),
  CONSTRAINT `fk_PreguntasDeSeguridad_credencial1` FOREIGN KEY (`CredencialId`) REFERENCES `credencial` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='En esta tabla se graban las preguntas de seguridad que se generan para recordar la contraseña';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preguntasseguridad`
--

LOCK TABLES `preguntasseguridad` WRITE;
/*!40000 ALTER TABLE `preguntasseguridad` DISABLE KEYS */;
INSERT INTO `preguntasseguridad` VALUES (1,'¿nombre de su primera mascota?','brayan',1),(2,'¿nombre de su abuela materna?','genobeva',2),(3,'¿color favorito?','verde',3);
/*!40000 ALTER TABLE `preguntasseguridad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador del producto que lo diferencia de los demas, no puede ir vacio y es auto incrementar.',
  `nombre` varchar(100) NOT NULL COMMENT 'Indica el nombre del producto, es obligatorio.',
  `talla` int(11) NOT NULL COMMENT 'En esta columna se guardan las tallas de los productos con los que cuenta la empresa',
  `color` varchar(50) NOT NULL COMMENT 'En esta columna define el color del producto',
  `precio` float NOT NULL COMMENT 'en esta columna validamos los precios de los productos',
  `cantidad` varchar(45) NOT NULL COMMENT 'en esta columna se visualiza la cantidad de un producto que se tiene en la empresa',
  `categoria_id` int(11) NOT NULL COMMENT 'Indica la categoria a la que pertenece el producto',
  PRIMARY KEY (`id`),
  KEY `fk_productos_categoria1_idx` (`categoria_id`),
  CONSTRAINT `fk_productos_categoria1` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Guarda la información relacionada al producto disponible';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'tennis',39,'negro',150000,'50',1),(2,'zapatos',29,'negro',90000,'30',3);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productosfactura`
--

DROP TABLE IF EXISTS `productosfactura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `productosfactura` (
  `ProductosId` int(11) NOT NULL COMMENT 'Indica el id del producto de tabla productos el cual esta toda su informacion ',
  `facturaId` int(11) NOT NULL COMMENT 'Indica el id de la factura de tabla factura el cual esta toda su informacion ',
  `cantidad` int(11) NOT NULL COMMENT 'Indica la cantidad que se solicito del producto en la respectiva factura',
  PRIMARY KEY (`ProductosId`,`facturaId`),
  KEY `fk_productos_has_factura_factura1_idx` (`facturaId`),
  KEY `fk_productos_has_factura_productos1_idx` (`ProductosId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guarda la información que relaciona los productos que se solicito en dicha factura';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productosfactura`
--

LOCK TABLES `productosfactura` WRITE;
/*!40000 ALTER TABLE `productosfactura` DISABLE KEYS */;
INSERT INTO `productosfactura` VALUES (1,1,2),(2,1,2);
/*!40000 ALTER TABLE `productosfactura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `proveedor` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Esta columna identifica de manera unica cada registro de los proveedores',
  `TipoDocumentoId` int(11) NOT NULL COMMENT 'en esta columna se valida con que tipo de documento cuenta cada provedor',
  `NumDocumento` int(11) NOT NULL COMMENT 'en esta columna se registra el numero de identificacion de los provedores',
  `NombreProveedor` varchar(100) NOT NULL COMMENT 'en este campo se registra el nombre del provedor.',
  `CorreoElectronico` varchar(100) NOT NULL COMMENT 'en esta columna se registra el correo electronico de los provedores',
  `direccion` varchar(45) DEFAULT NULL COMMENT 'en este campo encontraremos la ubicaion exacta de los provedores registrados en la empresa.',
  `telefono` varchar(50) DEFAULT NULL COMMENT 'este sera el numero de contacto de los proveedores registrados en el sistema.',
  PRIMARY KEY (`id`),
  KEY `fk_proveedor_tipo_documento1_idx` (`TipoDocumentoId`),
  CONSTRAINT `fk_proveedor_tipo_documento1` FOREIGN KEY (`TipoDocumentoId`) REFERENCES `tipodocumento` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='En esta tabla se guarda la información de  los provedores de la empresa';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (1,1,1024550110,'ADIDAS','adidasventas@adidas.com','cl 86 # 27-66','2458899'),(2,3,454546112,'NIKE','nikestubieras@gmail.com','cl 69 # 28-45','7889454');
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registro`
--

DROP TABLE IF EXISTS `registro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `registro` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la información personal, que lo diferencia de los demas registros. Es auto incrementar y no puede ir vacio.',
  `CredencialId` int(11) NOT NULL COMMENT 'id de la tabla credencial, la cual relaciona los datos de inicio de sesion con el registro. No puede ir vacio ya que los datos personales deben de tener un usuario.',
  `TipoDocumentoId` int(15) NOT NULL COMMENT 'id del tipo de documento que pertenece al registro, proveniente de la tabla "TipoDocumento". No puede ir vacio.',
  `NumDocumento` int(11) NOT NULL COMMENT 'indica el numero de documento del registro, es te tipo númerico y no puede ir vacio.',
  `PrimerNombre` varchar(100) NOT NULL COMMENT 'Indica el primer nombre al que pertenece el registro, no puede ir vacio ya que se debe conocer al menos el primer nombre.',
  `SegundoNombre` varchar(100) DEFAULT NULL COMMENT 'Indica el segundo nombre al que pertenece el registro, puede ir vacio ya que no es necesario conocer el segundo nombre.',
  `PrimerApellido` varchar(100) NOT NULL COMMENT 'Indica el primer apellido al que pertenece el registro, no puede ir vacio ya que se debe conocer al menos el primer apellido',
  `SegundoApellido` varchar(100) DEFAULT NULL COMMENT 'Indica el segundo apellido al que pertenece el registro, puede ir vacio ya que no es necesario conocer el segundo apellido',
  `CorreoElectronico` varchar(100) DEFAULT NULL COMMENT 'Indica el correo electronico del registro, puede ir vacio ya que no es necesario. Además de enviar posibles notificaciones.',
  `telefono` varchar(20) DEFAULT NULL COMMENT 'Número de telefono del registro, no es obligatorio y permite caracteres como ''+''',
  PRIMARY KEY (`id`),
  KEY `fk_IdRegistro_tipo_documento_idx` (`TipoDocumentoId`),
  KEY `fk_IdRegistro_credencial1_idx` (`CredencialId`),
  CONSTRAINT `fk_IdRegistro_credencial1` FOREIGN KEY (`CredencialId`) REFERENCES `credencial` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_IdRegistro_tipo_documento` FOREIGN KEY (`TipoDocumentoId`) REFERENCES `tipodocumento` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Esta tabla guarda la información de datos personales de los usuarios registrados.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registro`
--

LOCK TABLES `registro` WRITE;
/*!40000 ALTER TABLE `registro` DISABLE KEYS */;
INSERT INTO `registro` VALUES (1,1,2,1021214502,'andres','felipe','guzman','moreno','andres125.87@hotmail.com','7278546'),(2,2,2,1024555201,'blanca','cecilia','moreno','tierra','sadad123@gmail.com','1245211');
/*!40000 ALTER TABLE `registro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `rol` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla, no puede ir vacio y es auto incrementar. ',
  `NombreRol` varchar(100) NOT NULL COMMENT 'Indica el nombre del respectivo rol, por ende no puede ir vacio',
  `descripcion` varchar(100) DEFAULT NULL COMMENT 'Permite guardar detalles del rol correspondiente, es opcional',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Guarda la información de los roles disponibles a asignar en el sistema.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'Administrador','Administra Usuarios'),(2,'Vendedor','Factura'),(3,'Almacen','Valida inventario');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipodocumento`
--

DROP TABLE IF EXISTS `tipodocumento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tipodocumento` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla que lo diferencia de los demas tipos de documentos',
  `nombre` varchar(50) NOT NULL COMMENT 'Permite guardar el nombre del tipo de documento, no puede ir vacio.',
  `descripcion` varchar(50) DEFAULT NULL COMMENT 'Permite guardar detalles relacionados al tipo de documento, no es obligatorio',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='tabla de control que permite guardar los tipos de documentos disponibles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipodocumento`
--

LOCK TABLES `tipodocumento` WRITE;
/*!40000 ALTER TABLE `tipodocumento` DISABLE KEYS */;
INSERT INTO `tipodocumento` VALUES (1,'C.C','Cedula de Ciudadania'),(2,'T.I','Tarjeta de identidad'),(3,'Nit','Numero de identificacion tributaria'),(4,'Rut ','Registro Unico Tributario');
/*!40000 ALTER TABLE `tipodocumento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipopago`
--

DROP TABLE IF EXISTS `tipopago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tipopago` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla que permite diferenciar los tipos de pagos, no puede ir vacio y es auto incremental',
  `nombre` varchar(100) NOT NULL COMMENT 'Indica el nombre del tipo de pago, no puede ir vacio',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Tabla que permite controlar los tipos de pagos disponibles en el sistema';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipopago`
--

LOCK TABLES `tipopago` WRITE;
/*!40000 ALTER TABLE `tipopago` DISABLE KEYS */;
INSERT INTO `tipopago` VALUES (1,'efectivo'),(2,'tarjeda credito'),(3,'siste credito');
/*!40000 ALTER TABLE `tipopago` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-10 21:14:13
