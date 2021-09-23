part of appwrite.models;

class Team {
    final String $id;
    final String name;
    final int dateCreated;
    final int sum;

    Team({
        required this.$id,
        required this.name,
        required this.dateCreated,
        required this.sum,
    });

    factory Team.fromMap(Map<String, dynamic> map) {
        return Team(
            $id: map['\$id'],
            name: map['name'],
            dateCreated: map['dateCreated'],
            sum: map['sum'],
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "\$id": $id,
            "name": name,
            "dateCreated": dateCreated,
            "sum": sum,
        };
    }
}
