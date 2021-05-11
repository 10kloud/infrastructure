from pathlib import Path
import os, subprocess

class Infrastructure:

    def find_templates_dirs(self):
        """ Iterate templates directory to find troposphere scripts """
        paths = list()

        for path in Path("templates").iterdir():
            if "template.py" in os.listdir(path):
                paths.append(path)

        return paths

    def generate(self):
        """ Generates different cloudformation templates by stack """
        templates = self.find_templates_dirs()

        for template in templates:
            # Run scripts to generate cloudformation templates
            process = subprocess.Popen(
                ["python", f"{template}/template.py"],
                stdout=subprocess.PIPE
            )

            # Read the standard output of the files
            # to save it in a template.yml file
            stdout, _ = process.communicate()
            yaml = stdout.decode()

            with open(f"{template}/template.yml", "w") as template_file:
                # YAML file separator
                template_file.write("---\n")
                template_file.write(yaml)

    def aggregate(self):
        """ Aggregates all cloudformation yamls in only one file """
        templates = self.find_templates_dirs()

        partials = list()

        for template in templates:
            with open(f"{template}/template.yml", "r") as template_file:
                partial_template = template_file.read()
                partials.append(partial_template)

        with open("cloudformation.yml", "w") as manifest:
            manifest.write("".join(partials))

