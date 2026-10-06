import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CareApp extends StatefulWidget {
  const CareApp({super.key});
  @override
  State<CareApp> createState() => _CareAppState();
}

class _CareAppState extends State<CareApp> {
  final client = Supabase.instance.client;
  late final StreamSubscription<AuthState> subscription;
  @override
  void initState() {
    super.initState();
    subscription = client.auth.onAuthStateChange.listen((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => client.auth.currentSession == null
      ? const CareSignIn()
      : CareHome(key: ValueKey(client.auth.currentUser!.id));
}

class CareSignIn extends StatefulWidget {
  const CareSignIn({super.key});
  @override
  State<CareSignIn> createState() => _CareSignInState();
}

class _CareSignInState extends State<CareSignIn> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool busy = false;
  String? error;
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    setState(() {
      busy = true;
      error = null;
    });
    try {
      await Supabase.instance.client.auth.signInWithPassword(
          email: email.text.trim(), password: password.text);
    } catch (_) {
      if (mounted) {
        setState(() =>
            error = 'Could not sign in. Check your details and connection.');
      }
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: SafeArea(
          child: Center(
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(28),
                  child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 440),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Icon(Icons.health_and_safety_outlined,
                                size: 56, color: Color(0xff176653)),
                            const SizedBox(height: 20),
                            const Text('DocConnect',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            const Text(
                                'Your appointments. Your care team.\nAll in one place.',
                                textAlign: TextAlign.center),
                            const SizedBox(height: 32),
                            TextField(
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                decoration: const InputDecoration(
                                    labelText: 'Email',
                                    border: OutlineInputBorder())),
                            const SizedBox(height: 16),
                            TextField(
                                controller: password,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    labelText: 'Password',
                                    border: OutlineInputBorder())),
                            const SizedBox(height: 24),
                            FilledButton(
                                onPressed: busy ? null : signIn,
                                child: Text(busy ? 'Signing in…' : 'Sign in')),
                            if (error != null)
                              Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Text(error!,
                                      style:
                                          const TextStyle(color: Colors.red))),
                            const SizedBox(height: 20),
                            const Text(
                                'Use the patient account provided by your clinic.',
                                textAlign: TextAlign.center),
                          ]))))));
}

class CareHome extends StatefulWidget {
  const CareHome({super.key});
  @override
  State<CareHome> createState() => _CareHomeState();
}

class _CareHomeState extends State<CareHome> {
  final client = Supabase.instance.client;
  List<Map<String, dynamic>> appointments = [];
  List<Map<String, dynamic>> notifications = [];
  Map<String, String> doctors = {};
  Timer? timer;
  bool loading = true;
  bool isPatient = false;
  String? error;
  int tab = 0;
  @override
  void initState() {
    super.initState();
    refresh();
    timer = Timer.periodic(const Duration(seconds: 30), (_) => refresh());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> refresh() async {
    try {
      final uid = client.auth.currentUser!.id;
      final profile = await client
          .from('care_people')
          .select('role')
          .eq('id', uid)
          .maybeSingle();
      if (profile?['role'] != 'patient') {
        if (mounted) {
          setState(() {
            isPatient = false;
            loading = false;
          });
        }
        return;
      }
      final rows = await client
          .from('care_appointments')
          .select('*,care_slots(*)')
          .eq('patient_id', uid)
          .order('created_at', ascending: false);
      final inbox = await client
          .from('care_notifications')
          .select()
          .eq('patient_id', uid)
          .order('created_at', ascending: false);
      final people = await client
          .from('care_people')
          .select('id,display_name')
          .eq('role', 'doctor');
      if (mounted) {
        setState(() {
          appointments = rows;
          notifications = inbox;
          doctors = {
            for (final p in people)
              p['id'] as String: p['display_name'] as String
          };
          loading = false;
          isPatient = true;
          error = null;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          loading = false;
          error = 'Could not refresh your care information. Please try again.';
        });
      }
    }
  }

  String date(String value) {
    final d = DateTime.parse(value).toLocal();
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year} · ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }

  Future<void> markRead(String id) async {
    try {
      await client.from('care_notifications').update(
          {'read_at': DateTime.now().toUtc().toIso8601String()}).eq('id', id);
      await refresh();
    } catch (_) {
      if (mounted) {
        setState(() => error = 'Could not mark notification as read.');
      }
    }
  }

  Future<void> setPassword() async {
    final password = TextEditingController();
    bool saving = false;
    String? message;
    try {
      await showDialog<void>(
          context: context,
          builder: (dialogContext) => StatefulBuilder(
              builder: (dialogContext, setDialogState) => AlertDialog(
                    title: const Text('Set your password'),
                    content: Column(mainAxisSize: MainAxisSize.min, children: [
                      const Text(
                          'Use this password to sign in to DocConnect after accepting your invitation.'),
                      const SizedBox(height: 16),
                      TextField(
                          controller: password,
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: 'New password',
                              border: OutlineInputBorder())),
                      if (message != null)
                        Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(message!,
                                style: const TextStyle(color: Colors.red)))
                    ]),
                    actions: [
                      TextButton(
                          onPressed: saving
                              ? null
                              : () => Navigator.pop(dialogContext),
                          child: const Text('Cancel')),
                      FilledButton(
                          onPressed: saving
                              ? null
                              : () async {
                                  if (password.text.length < 8) {
                                    setDialogState(() =>
                                        message = 'Use at least 8 characters.');
                                    return;
                                  }
                                  setDialogState(() {
                                    saving = true;
                                    message = null;
                                  });
                                  try {
                                    await client.auth.updateUser(UserAttributes(
                                        password: password.text));
                                    if (dialogContext.mounted) {
                                      Navigator.pop(dialogContext);
                                    }
                                    if (mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text('Password saved.')));
                                    }
                                  } catch (_) {
                                    setDialogState(() {
                                      saving = false;
                                      message =
                                          'Could not save your password. Please try again.';
                                    });
                                  }
                                },
                          child: Text(saving ? 'Saving…' : 'Save password'))
                    ],
                  )));
    } finally {
      password.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final rows = appointments
        .where((a) =>
            tab == 0 ? a['status'] == 'scheduled' : a['status'] != 'scheduled')
        .toList();
    rows.sort((a, b) {
      final comparison = DateTime.parse(a['care_slots']['starts_at'])
          .compareTo(DateTime.parse(b['care_slots']['starts_at']));
      return tab == 0 ? comparison : -comparison;
    });
    final unread = notifications.where((n) => n['read_at'] == null).length;
    return Scaffold(
        appBar: AppBar(title: const Text('DocConnect'), actions: [
          IconButton(
              tooltip: 'Set password',
              onPressed: setPassword,
              icon: const Icon(Icons.lock_outline)),
          IconButton(
              tooltip: 'Refresh',
              onPressed: refresh,
              icon: const Icon(Icons.refresh)),
          IconButton(
              tooltip: 'Sign out',
              onPressed: () async {
                try {
                  await client.auth.signOut();
                } catch (_) {
                  if (mounted) {
                    setState(() => error = 'Could not sign out. Try again.');
                  }
                }
              },
              icon: const Icon(Icons.logout))
        ]),
        bottomNavigationBar: NavigationBar(
            selectedIndex: tab,
            onDestinationSelected: (i) => setState(() => tab = i),
            destinations: [
              const NavigationDestination(
                  icon: Icon(Icons.calendar_month), label: 'Appointments'),
              const NavigationDestination(
                  icon: Icon(Icons.history), label: 'History'),
              NavigationDestination(
                  icon: Badge(
                      label: Text('$unread'),
                      isLabelVisible: unread > 0,
                      child: const Icon(Icons.notifications_outlined)),
                  label: 'Notifications')
            ]),
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: refresh,
                child: ListView(
                    padding: const EdgeInsets.all(24),
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      Text(
                          [
                            'Your upcoming care',
                            'Your checkup history',
                            'Your notifications'
                          ][tab],
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text('Connected to your doctors through Zoctor.'),
                      const SizedBox(height: 8),
                      const Text(
                          'Newly invited? Use the lock icon above to set your password.'),
                      const SizedBox(height: 24),
                      if (error != null)
                        Card(
                            child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(error!,
                                    style:
                                        const TextStyle(color: Colors.red)))),
                      if (!isPatient)
                        const Card(
                            child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                    'Your patient account is not active yet. Ask your clinic administrator to connect your account.')))
                      else if (tab == 2) ...[
                        if (notifications.isEmpty)
                          const Text(
                              'You’re all caught up. Appointment updates and reminders will appear here.'),
                        ...notifications.map((n) => Card(
                            child: ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                leading: Icon(n['kind'] == 'reminder'
                                    ? Icons.alarm
                                    : Icons.notifications_active_outlined),
                                title: Text(n['message']),
                                subtitle: Text(date(n['created_at'])),
                                trailing: n['read_at'] == null
                                    ? TextButton(
                                        onPressed: () => markRead(n['id']),
                                        child: const Text('Mark read'))
                                    : const Icon(Icons.done))))
                      ] else ...[
                        if (rows.isEmpty)
                          Text(tab == 0
                              ? 'No upcoming appointments. Your doctor can arrange your next visit.'
                              : 'Your completed checkups and cancelled appointments will appear here.'),
                        ...rows.map((a) {
                          final slot = a['care_slots'] as Map<String, dynamic>;
                          final starts = DateTime.parse(slot['starts_at']);
                          final remaining = starts.difference(DateTime.now());
                          return Card(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            doctors[slot['doctor_id']] ??
                                                'Your doctor',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600)),
                                        const SizedBox(height: 8),
                                        Text(date(slot['starts_at'])),
                                        const SizedBox(height: 8),
                                        Chip(
                                            label: Text((a['status'] as String)
                                                .replaceAll('_', ' '))),
                                        if (tab == 0 &&
                                            remaining > Duration.zero &&
                                            remaining <=
                                                const Duration(hours: 24))
                                          const Padding(
                                              padding: EdgeInsets.only(top: 8),
                                              child: Text(
                                                  'Reminder: your appointment is within 24 hours.',
                                                  style: TextStyle(
                                                      color: Color(0xff176653),
                                                      fontWeight:
                                                          FontWeight.w600))),
                                        if ((a['summary'] as String)
                                            .isNotEmpty) ...[
                                          const Divider(),
                                          const Text('Checkup summary',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 8),
                                          Text(a['summary'])
                                        ],
                                      ])));
                        }),
                      ],
                    ])));
  }
}
