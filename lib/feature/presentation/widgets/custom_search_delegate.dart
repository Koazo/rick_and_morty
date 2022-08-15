import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search/search_bloc.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search/search_event.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search/search_state.dart';
import 'package:rick_and_morty/feature/presentation/widgets/search_result.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search for characters...');

  final _suggestions = [
    'Rick',
    'Morty',
    'Summer',
    'Beth',
    'Jerry',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_outlined),
      onPressed: () => close(context, null),
      tooltip: 'Back',
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print('Inside Custom Seatch delegate and search query is $query');
    BlocProvider.of<PersonSearchBloc>(context, listen: false)
        .add(SearchPersons(query));
    return BlocBuilder<PersonSearchBloc, PersonSearchState>(
      builder: ((context, state) {
        if (state is PersonSearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PersonSearchLoaded) {
          final person = state.persons;
          if (person.isEmpty) {
            return _showErrorText('No characters with that name found');
          }
          return Container(
            child: ListView.builder(
                itemCount: person.isNotEmpty ? person.length : 0,
                itemBuilder: (context, index) {
                  PersonEntity result = person[index];
                  return SearchResult(personResult: result);
                }),
          );
        } else if (state is PersonSearchError) {
          return _showErrorText(state.message);
        } else {
          return const Center(
            child: Icon(Icons.now_wallpaper),
          );
        }
      }),
    );
  }

  Widget _showErrorText(String errorMessage) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          errorMessage,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length > 0) {
      return Container();
    }
    return ListView.separated(
        padding: const EdgeInsets.all(11),
        itemBuilder: ((context, index) {
          return Text(
            _suggestions[index],
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          );
        }),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: _suggestions.length);
  }
}
