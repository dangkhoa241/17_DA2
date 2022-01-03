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
    public partial class Form0 : Form
    {
        string connectString;
        SqlConnection conn;
        public Form0()
        {
            InitializeComponent();
        }

        private void Form0_Load(object sender, EventArgs e)
        {
            connectString = @"Data Source=KHOA\SQLEXPRESS;Initial Catalog=ONLINE_SHOP;Integrated Security=True";
            conn = new SqlConnection(connectString);
            conn.Open();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Form1 f1 = new Form1();
            f1.connectString = connectString;
            f1.PH = "KH";
            this.Hide();
            f1.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            conn.Close();
            Application.Exit();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            Form1 f1 = new Form1();
            f1.connectString = connectString;
            f1.PH = "NV";
            this.Hide();
            f1.Show();
        }
    }
}
