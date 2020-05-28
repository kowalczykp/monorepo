import 'package:flutter/material.dart';
import 'package:metrics/common/presentation/metrics_theme/state/theme_notifier.dart';
import 'package:metrics/common/presentation/strings/common_strings.dart';
import 'package:metrics/common/presentation/widgets/metrics_card.dart';
import 'package:metrics/project_groups/presentation/model/project_group_view_model.dart';
import 'package:metrics/project_groups/presentation/strings/project_groups_strings.dart';
import 'package:metrics/project_groups/presentation/widgets/project_group_delete_dialog.dart';
import 'package:metrics/project_groups/presentation/widgets/project_group_dialog.dart';
import 'package:provider/provider.dart';

/// A widget that represent [projectGroupViewModel].
class ProjectGroupCard extends StatelessWidget {
  final ProjectGroupViewModel projectGroupViewModel;

  /// Creates the [ProjectGroupCard].
  ///
  /// [projectGroupViewModel] should not be null.
  ///
  /// [projectGroupViewModel] represents project group data for UI.
  const ProjectGroupCard({
    Key key,
    @required this.projectGroupViewModel,
  })  : assert(projectGroupViewModel != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MetricsCard(
      backgroundColor:
          themeNotifier.isDark ? Colors.grey[900] : Colors.grey[200],
      padding: const EdgeInsets.all(16.0),
      elevation: 0.0,
      title: Text(
        projectGroupViewModel.name,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        maxLines: 1,
        style: const TextStyle(fontSize: 24.0),
      ),
      titlePadding: const EdgeInsets.all(8.0),
      subtitle: Text(_projectGroupsCount),
      subtitlePadding: const EdgeInsets.all(8.0),
      actionsPadding: const EdgeInsets.only(top: 24.0),
      actions: <Widget>[
        FlatButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return ProjectGroupDialog(
                  projectGroupViewModel: projectGroupViewModel,
                );
              },
            );
          },
          icon: Icon(Icons.edit),
          label: const Text(CommonStrings.edit),
        ),
        FlatButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return ProjectGroupDeleteDialog(
                  projectGroupViewModel: projectGroupViewModel,
                );
              },
            );
          },
          icon: const Icon(Icons.delete_outline),
          label: const Text(CommonStrings.delete),
        ),
      ],
    );
  }

  /// Provides a project groups count for the given [projectGroupViewModel].
  String get _projectGroupsCount {
    final projectsCount = projectGroupViewModel.projectIds?.length ?? 0;
    return projectsCount == 0
        ? ProjectGroupsStrings.noProjects
        : ProjectGroupsStrings.getProjectsCount(projectsCount);
  }
}
