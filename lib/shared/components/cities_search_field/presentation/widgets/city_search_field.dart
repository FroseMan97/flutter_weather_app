import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/core/localization/app_localization.dart';
import '../bloc/cities_cubit.dart';
import '../bloc/cities_state.dart';
import '../../domain/entities/city.dart';
import 'cities_loading_widget.dart';
import 'cities_loaded_widget.dart';
import 'cities_empty_widget.dart';
import 'cities_error_widget.dart';

class CitySearchField extends StatefulWidget {
  final Function(City) onCitySelected;
  final VoidCallback? onClearSearch;

  const CitySearchField({
    super.key,
    required this.onCitySelected,
    this.onClearSearch,
  });

  @override
  State<CitySearchField> createState() => _CitySearchFieldState();
}

class _CitySearchFieldState extends State<CitySearchField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _onCitySelected(City city) {
    _controller.text = '${city.name}, ${city.countryCode}';
    _focusNode.unfocus();
    widget.onCitySelected(city);
    _removeOverlay();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay() {
    _removeOverlay();
    
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final currentState = context.read<CitiesCubit>().state;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy + size.height + 8,
        width: size.width,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            constraints: const BoxConstraints(
              maxHeight: 300, // Максимум 300px для защиты от очень длинных списков
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: _buildOverlayContent(currentState),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget _buildOverlayContent(CitiesState state) {
    return state.when(
      initial: () => const SizedBox.shrink(),
      loading: () => const CitiesLoadingWidget(),
      loaded: (cities, showSuggestions) => showSuggestions 
        ? CitiesLoadedWidget(
            cities: cities,
            onCitySelected: _onCitySelected,
          )
        : const SizedBox.shrink(),
      empty: () => const CitiesEmptyWidget(),
      error: (message) => CitiesErrorWidget(message: message),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CitiesCubit, CitiesState>(
      listener: (context, state) {
        // Показываем/скрываем overlay
        state.when(
          initial: () => _removeOverlay(),
          loading: () => _showOverlay(),
          loaded: (cities, showSuggestions) {
            if (showSuggestions) {
              _showOverlay();
            } else {
              _removeOverlay();
            }
          },
          empty: () => _showOverlay(),
          error: (message) => _showOverlay(),
        );
      },
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        decoration: InputDecoration(
          labelText: AppLocalization.searchCity,
          hintText: AppLocalization.enterCityName,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    context.read<CitiesCubit>().clearSearch();
                    widget.onClearSearch?.call();
                    _removeOverlay();
                  },
                )
              : null,
          border: const OutlineInputBorder(),
        ),
        onChanged: (value) {
          context.read<CitiesCubit>().searchCities(
            value,
            cityNameOnlyLettersMessage: AppLocalization.cityNameOnlyLetters,
          );
        },
        onTap: () {
          if (_controller.text.isNotEmpty) {
            context.read<CitiesCubit>().showSuggestions();
          }
        },
      ),
    );
  }

}
