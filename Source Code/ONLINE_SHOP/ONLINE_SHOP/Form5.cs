using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace ONLINE_SHOP
{
    public partial class Form5 : Form
    {
        public string connectString;
        public string tendn;
        SqlConnection conn;
        public Form5()
        {
            InitializeComponent();
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void Form5_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(connectString);
            conn.Open();
            label2.Text = tendn;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Form8 f8 = new Form8();
            f8.connectString = connectString;
            f8.tendn = tendn;
            this.Hide();
            f8.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Form10 f10 = new Form10();
            f10.connectString = connectString;
            this.Hide();
            f10.Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {

        }

        private void btnLogout_Click(object sender, EventArgs e)
        {
            conn.Close();
            Form1 f1 = new Form1();
            f1.connectString = connectString;
            this.Close();
            f1.Show();
        }
    }
}
