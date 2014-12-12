docker run -d --name tzardb javimarlop/postgres91-tzar-docker

#docker run -p 5432 -ti --name tzardb javimarlop/postgres91-tzar-docker /bin/bash

#docker run -d --name ugis javimarlop/ubuntugis-docker #/bin/bash

docker run -d -P --name ugis --link tzardb:tzardb javimarlop/ubuntugis-docker /bin/bash

docker run -ti ugis javimarlop/ubuntugis-docker /bin/bash

###

docker run -d --name tzardb javimarlop/postgres91-tzar-docker

docker run -d -P --name ugis --link tzardb:tzardb javimarlop/ubuntugis-docker /bin/bash

docker run -t -i --link tzardb:tzardb javimarlop/ubuntugis-docker /bin/bash


